import { HttpStatus, Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { CreateCatDto } from "./dto/create-cat.dto";
import { Cat, CatDocument } from "./schemas/cat.schema";
import { Response } from "express";
import { UpdateCatDto } from "./dto/update-cat.dto";
import { PatchCatDto } from "./dto/patch-cat.dto";

@Injectable()
export class CatsService {
    constructor(
        @InjectModel(Cat.name) private readonly catModel: Model<CatDocument>
    ) {}

    async create(
        createCatDto: CreateCatDto,
        response: Response
    ): Promise<any | undefined> {
        try {
            const createdCat = await this.catModel.create(createCatDto);
            response.status(HttpStatus.CREATED).send(createdCat);
        } catch (e: any) {
            response.status(HttpStatus.BAD_REQUEST).send(e.toString());
        }
    }

    async findAll(
        response: Response,
        limit?: number,
        page?: number
    ): Promise<any | undefined> {
        try {
            const foundCat = await this.catModel
                .find()
                .limit(limit ?? 10)
                .skip(((page ?? 1) - 1) * limit)
                .exec();
            response.status(HttpStatus.OK).send(foundCat);
        } catch (e: any) {
            response.status(HttpStatus.BAD_REQUEST).send(e.toString());
        }
    }

    async findOne(id: string, response: Response): Promise<any | undefined> {
        try {
            const foundOneCat = await this.catModel.findOne({ _id: id }).exec();
            if (foundOneCat != null) {
                response.status(HttpStatus.OK).send(foundOneCat);
            } else {
                response
                    .status(HttpStatus.NOT_FOUND)
                    .send("Data not found" + foundOneCat);
            }
        } catch (e: any) {
            response.status(HttpStatus.BAD_REQUEST).send(e.toString());
        }
    }

    async findOneAndUpdate(
        id: string,
        response: Response,
        updateCatDto: UpdateCatDto | PatchCatDto
    ): Promise<any | undefined> {
        try {
            // finding one
            const foundOneCat = await this.catModel
                .findOneAndUpdate({ _id: id }, updateCatDto)
                .exec();
            // patching
            response
                .status(HttpStatus.OK)
                .send({ data: foundOneCat, changed: updateCatDto });
        } catch (e: any) {
            response.status(HttpStatus.BAD_REQUEST).send(e.toString());
        }
    }

    async delete(id: string, response: Response) {
        try {
            const deletedCat = await this.catModel
                .findByIdAndRemove({ _id: id })
                .exec();
            if (deletedCat) {
                response.status(HttpStatus.NO_CONTENT).send(deletedCat);
            } else {
                throw new Error("Nothing to delete");
            }
        } catch (e: any) {
            response.status(HttpStatus.BAD_REQUEST).send(e.toString());
        }
    }
}
