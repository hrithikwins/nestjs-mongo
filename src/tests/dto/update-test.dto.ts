import { OmitType } from "@nestjs/mapped-types";
import { CreatetestDto } from "./create-test.dto";

export class UpdatetestDto extends OmitType(CreatetestDto, ["_id"] as const) {}
