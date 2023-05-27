import { PartialType } from "@nestjs/mapped-types";

import { CreateCatDto } from "./create-cat.dto";

export class PatchCatDto extends PartialType(CreateCatDto) {}
