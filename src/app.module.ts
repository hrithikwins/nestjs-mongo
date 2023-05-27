import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { CatsModule } from "./cats/cats.module";

@Module({
    imports: [
        MongooseModule.forRoot(
            "<your-mongodb-connection-string>"
        ),
        CatsModule,
    ],
})
export class AppModule {}
