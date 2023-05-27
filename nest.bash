###############################################
## usage: > bash nest.bash <your-resourcename>   ##########
## (resourcename like cat,mat,topic,course in singularNoun) ###
#############################################
SCHEMA_NAME=${*^}
SCHEMA_DOCUMENT="${SCHEMA_NAME}Document"
SCHEMA_SCHEMA="${SCHEMA_NAME}Schema"
SCHEMA_LOWCASE="${SCHEMA_NAME,,}"
SCHEMA_PATH="src/${SCHEMA_LOWCASE}s/schemas/${SCHEMA_LOWCASE}.schema.ts"
DTO_PATHC="src/${SCHEMA_LOWCASE}s/dto/create-${SCHEMA_LOWCASE}.dto.ts"
DTO_PATHP="src/${SCHEMA_LOWCASE}s/dto/patch-${SCHEMA_LOWCASE}.dto.ts"
DTO_PATHU="src/${SCHEMA_LOWCASE}s/dto/update-${SCHEMA_LOWCASE}.dto.ts"
nest g resource ${SCHEMA_LOWCASE}s
nest generate class ${SCHEMA_LOWCASE}s/dto/create-$SCHEMA_LOWCASE.dto
nest generate class ${SCHEMA_LOWCASE}s/dto/patch-$SCHEMA_LOWCASE.dto
nest generate class ${SCHEMA_LOWCASE}s/dto/update-$SCHEMA_LOWCASE.dto
# # Create a new schema file for MongoDB
mkdir "src/${SCHEMA_LOWCASE}s/schemas" && touch $SCHEMA_PATH
# reading from json and storing in a variable
OUTPUT_FILES=
# writing to a file here
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
" > $SCHEMA_PATH

# creating dto path
echo "import { IsNotEmpty, IsString } from \"class-validator\";

export class Create${SCHEMA_NAME}Dto {
  @IsString()
  _id: string;

  @IsNotEmpty()
  name: string;

  @IsNotEmpty()
  age: number;

  @IsNotEmpty()
  breed: string;
}" > $DTO_PATHC


echo "import { PartialType } from \"@nestjs/mapped-types\";

import { Create${SCHEMA_NAME}Dto } from \"./create-${SCHEMA_LOWCASE}.dto\";

export class Patch${SCHEMA_NAME}Dto extends PartialType(Create${SCHEMA_NAME}Dto) {}" > $DTO_PATHP

echo "import { OmitType } from \"@nestjs/mapped-types\";
import { Create${SCHEMA_NAME}Dto } from \"./create-${SCHEMA_LOWCASE}.dto\";

export class Update${SCHEMA_NAME}Dto extends OmitType(Create${SCHEMA_NAME}Dto, [\"_id\"] as const) {}" > $DTO_PATHU

rm src/${SCHEMA_LOWCASE}s/dto/create-$SCHEMA_LOWCASE.dto.spec.ts
rm src/${SCHEMA_LOWCASE}s/dto/patch-$SCHEMA_LOWCASE.dto.spec.ts
rm src/${SCHEMA_LOWCASE}s/dto/update-$SCHEMA_LOWCASE.dto.spec.ts
rm src/${SCHEMA_LOWCASE}/$SCHEMA_LOWCASE.controller.spec.ts
rm src/${SCHEMA_LOWCASE}/$SCHEMA_LOWCASE.service.spec.ts