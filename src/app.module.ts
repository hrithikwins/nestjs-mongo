import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { CatsModule } from "./cats/cats.module";
import { UsersModule } from './users/users.module';

@Module({
  imports: [MongooseModule.forRoot("mongodb+srv://javaoncloud14:YJOt6KZAhXYQLedV@cluster0.y41jkid.mongodb.net/?retryWrites=true&w=majority"), CatsModule, UsersModule],
})
export class AppModule {}
