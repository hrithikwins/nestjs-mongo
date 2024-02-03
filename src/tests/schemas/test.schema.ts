import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

export type testDocument = test & Document;

@Schema()
export class test {
    @Prop()
    _id: string;

    @Prop()
    name: string;
}
export const testSchema = SchemaFactory.createForClass(test);

