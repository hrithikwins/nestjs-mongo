#!/bin/bash

# Usage: bash nest.bash <your-resourcename>
## (resourcename like cat,mat,topic,course in singularNoun) ###

SCHEMA_NAME=$1
SCHEMA_DOCUMENT="${SCHEMA_NAME}Document"
SCHEMA_SCHEMA="${SCHEMA_NAME}Schema"
SCHEMA_LOWCASE=$(echo "$SCHEMA_NAME" | tr '[:upper:]' '[:lower:]')
SCHEMA_CAPITALIZED="$(tr '[:lower:]' '[:upper:]' <<< ${SCHEMA_LOWCASE:0:1})${SCHEMA_LOWCASE:1}"

echo "Original Schema Name: $SCHEMA_NAME"
echo "Document Schema: $SCHEMA_DOCUMENT"
echo "Schema Schema: $SCHEMA_SCHEMA"
echo "Lowercase Schema: $SCHEMA_LOWCASE"
echo "Capitalized Schema: $SCHEMA_CAPITALIZED"


SCHEMA_PATH="src/${SCHEMA_LOWCASE}s/schemas/${SCHEMA_LOWCASE}.schema.ts"
DTO_PATHC="src/${SCHEMA_LOWCASE}s/dto/create-${SCHEMA_LOWCASE}.dto.ts"
DTO_PATHP="src/${SCHEMA_LOWCASE}s/dto/patch-${SCHEMA_LOWCASE}.dto.ts"
DTO_PATHU="src/${SCHEMA_LOWCASE}s/dto/update-${SCHEMA_LOWCASE}.dto.ts"

nest g resource "${SCHEMA_LOWCASE}s"
nest generate class "${SCHEMA_LOWCASE}s/dto/create-$SCHEMA_LOWCASE.dto"
nest generate class "${SCHEMA_LOWCASE}s/dto/patch-$SCHEMA_LOWCASE.dto"
# nest generate class "${SCHEMA_LOWCASE}s/dto/update-$SCHEMA_LOWCASE.dto"

# Create a new schema file for MongoDB
mkdir -p "src/${SCHEMA_LOWCASE}s/schemas" && touch "$SCHEMA_PATH"

# Writing to a file
echo "import { Prop, Schema, SchemaFactory } from \"@nestjs/mongoose\";
import { Document } from \"mongoose\";

export type $SCHEMA_DOCUMENT = $SCHEMA_NAME & Document;

@Schema()
export class $SCHEMA_NAME {
    @Prop()
    _id: string;

    @Prop()
    name: string;
}
export const $SCHEMA_SCHEMA = SchemaFactory.createForClass($SCHEMA_NAME);
" > "$SCHEMA_PATH"

# Creating dto path
echo "import { IsNotEmpty, IsString } from \"class-validator\";

export class Create${SCHEMA_CAPITALIZED}Dto {
  @IsString()
  _id: string;

  @IsNotEmpty()
  name: string;

  @IsNotEmpty()
  age: number;

  @IsNotEmpty()
  breed: string;
}" > "$DTO_PATHC"

echo "import { PartialType } from \"@nestjs/mapped-types\";

import { Create${SCHEMA_CAPITALIZED}Dto } from \"./create-${SCHEMA_LOWCASE}.dto\";

export class Patch${SCHEMA_CAPITALIZED}Dto extends PartialType(Create${SCHEMA_CAPITALIZED}Dto) {}" > "$DTO_PATHP"

echo "import { OmitType } from \"@nestjs/mapped-types\";
import { Create${SCHEMA_CAPITALIZED}Dto } from \"./create-${SCHEMA_LOWCASE}.dto\";

export class Update${SCHEMA_CAPITALIZED}Dto extends OmitType(Create${SCHEMA_CAPITALIZED}Dto, [\"_id\"] as const) {}" > "$DTO_PATHU"

# Remove unnecessary files
rm "src/${SCHEMA_LOWCASE}s/dto/create-$SCHEMA_LOWCASE.dto.spec.ts"
rm "src/${SCHEMA_LOWCASE}s/dto/patch-$SCHEMA_LOWCASE.dto.spec.ts"
rm "src/${SCHEMA_LOWCASE}s/dto/update-$SCHEMA_LOWCASE.dto.spec.ts"
rm "src/${SCHEMA_LOWCASE}/${SCHEMA_LOWCASE}s.controller.spec.ts"
rm "src/${SCHEMA_LOWCASE}/${SCHEMA_LOWCASE}s.service.spec.ts"
