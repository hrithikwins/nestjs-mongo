import { IsNotEmpty, IsString } from "class-validator";
export class CreateCatDto {
    @IsString()
    _id: string;

    @IsNotEmpty()
    name: string;

    @IsNotEmpty()
    age: number;

    @IsNotEmpty()
    breed: string;
}
