import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService
  ) {}

  async register(registerDto: RegisterDto) {
    const { pseudo, password, ...rest } = registerDto;
    const saltAndHash = await bcrypt.hash(password, 10);
    const newUser = await this.usersService.create({
      pseudo,
      passwordHash: saltAndHash,
      ...rest,
    });
    return this.login({ pseudo, password });
  }

  async login(loginDto: LoginDto) {
    const user = await this.usersService.findByPseudo(loginDto.pseudo);
    if (!user) {
      throw new UnauthorizedException('Identifiants incorrects');
    }
    const isPasswordValid = await bcrypt.compare(loginDto.password, user.passwordHash);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Identifiants incorrects');
    }

    const payload = { sub: user._id, pseudo: user.pseudo, role: user.role };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
