import {
    Body,
    Controller,
    Delete,
    Get,
    Param,
    Patch,
    Post,
    Put,
    Query,
    Res,
} from "@nestjs/common";
import { CatsService } from "./cats.service";
import { CreateCatDto } from "./dto/create-cat.dto";
import { Cat } from "./schemas/cat.schema";
import { Response } from "express";
import { UpdateCatDto } from "./dto/update-cat.dto";
import { PatchCatDto } from "./dto/patch-cat.dto";

@Controller("cats")
export class CatsController {
    constructor(private readonly catsService: CatsService) {}

    @Post()
    async create(
        @Body() createCatDto: CreateCatDto,
        @Res() response: Response
    ) {
        await this.catsService.create(createCatDto, response);
    }

    @Get()
    async findSomeone(
        @Res() response: Response,
        @Query("page") page: number,
        @Query("limit") limit: number
    ): Promise<Cat[]> {
        return this.catsService.findAll(response, limit, page);
    }

    @Get(":id")
    async findOne(
        @Param("id") id: string,
        @Res() response: Response
    ): Promise<Cat> {
        return this.catsService.findOne(id, response);
    }

    @Put(":id")
    async findOneAndUpdate(
        @Param("id") id: string,
        @Res() response: Response,
        @Body() updateCatDto: UpdateCatDto
    ): Promise<Cat> {
        return this.catsService.findOneAndUpdate(id, response, updateCatDto);
    }

    @Patch(":id")
    async findOneAndPatch(
        @Param("id") id: string,
        @Res() response: Response,
        @Body() patchCatDto: PatchCatDto
    ): Promise<Cat> {
        return this.catsService.findOneAndUpdate(id, response, patchCatDto);
    }

    @Delete(":id")
    async delete(@Param("id") id: string, @Res() response: Response) {
        return this.catsService.delete(id, response);
    }
}
