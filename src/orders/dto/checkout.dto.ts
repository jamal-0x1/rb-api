import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMinSize,
  IsArray,
  IsEmail,
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
} from 'class-validator';

export class CheckoutItemDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  variantId!: string;

  @ApiProperty({ minimum: 1 })
  @IsInt()
  @Min(1)
  quantity!: number;
}

export class CheckoutAddressDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  firstName!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  lastName!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  line1!: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  line2?: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  city!: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  state?: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  postalCode!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  country!: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  phone!: string;

  @ApiProperty()
  @IsEmail()
  email!: string;
}

export class CheckoutDto {
  @ApiProperty({ type: [CheckoutItemDto] })
  @IsArray()
  @ArrayMinSize(1)
  @ValidateNested({ each: true })
  @Type(() => CheckoutItemDto)
  items!: CheckoutItemDto[];

  @ApiProperty({ type: CheckoutAddressDto })
  @ValidateNested()
  @Type(() => CheckoutAddressDto)
  shipping!: CheckoutAddressDto;

  @ApiProperty({ enum: ['cod'], default: 'cod' })
  @IsIn(['cod'])
  paymentMethod!: 'cod';

  @ApiProperty({ enum: ['free', 'standard', 'express'], default: 'standard' })
  @IsOptional()
  @IsIn(['free', 'standard', 'express'])
  shippingMethod?: 'free' | 'standard' | 'express';

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  couponCode?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  notes?: string;
}
