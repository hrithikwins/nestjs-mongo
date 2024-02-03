import { OmitType } from "@nestjs/mapped-types";
import { CreateUserDto } from "./create-user.dto";

export class UpdateuserDto extends OmitType(CreateUserDto, ["_id"] as const) {}
