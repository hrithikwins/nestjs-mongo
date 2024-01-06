import { OmitType } from "@nestjs/mapped-types";
import { CreateuserDto } from "./create-user.dto";

export class UpdateuserDto extends OmitType(CreateuserDto, ["_id"] as const) {}
