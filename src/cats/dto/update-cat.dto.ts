import { OmitType } from "@nestjs/mapped-types";
import { CreateCatDto } from "./create-cat.dto";

export class UpdateCatDto extends OmitType(CreateCatDto, ["_id"] as const) {}
