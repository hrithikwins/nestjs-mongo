import { IsNotEmpty, IsString } from "class-validator";

export class CreateUserDto {
  @IsString()
  _id: string;

  @IsNotEmpty()
  name: string;

  @IsNotEmpty()
  age: number;

  @IsNotEmpty()
  breed: string;
}
