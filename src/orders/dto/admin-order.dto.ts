import {
  ArrayMinSize,
  IsArray,
  IsInt,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';

export class AdminOrderItemDto {
  @IsString()
  variantId!: string;

  @IsInt()
  @Min(1)
  quantity!: number;
}

export class AdminCreateOrderShippingDto {
  @IsString() line1!: string;
  @IsOptional() @IsString() line2?: string;
  @IsString() city!: string;
  @IsOptional() @IsString() state?: string;
  @IsString() postalCode!: string;
  @IsString() country!: string;
}

export class AdminCreateOrderDto {
  @IsString()
  userId!: string;

  @IsArray()
  @ArrayMinSize(1)
  @ValidateNested({ each: true })
  @Type(() => AdminOrderItemDto)
  items!: AdminOrderItemDto[];

  @ValidateNested()
  @Type(() => AdminCreateOrderShippingDto)
  shipping!: AdminCreateOrderShippingDto;

  @IsOptional()
  @IsString()
  shippingMethod?: 'free' | 'standard' | 'express';

  @IsOptional()
  @IsString()
  paymentMethod?: 'cod';

  @IsOptional()
  @IsString()
  status?: string;

  @IsOptional()
  @IsString()
  couponCode?: string;

  @IsOptional()
  @IsString()
  notes?: string;
}

export class AddOrderItemDto {
  @IsString()
  variantId!: string;

  @IsInt()
  @Min(1)
  quantity!: number;
}

export class UpdateOrderItemDto {
  @IsInt()
  @Min(1)
  quantity!: number;
}
