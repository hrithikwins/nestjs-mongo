import { PartialType } from "@nestjs/mapped-types";

import { CreatetestDto } from "./create-test.dto";

export class PatchtestDto extends PartialType(CreatetestDto) {}
