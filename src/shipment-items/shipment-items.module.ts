import { Module } from '@nestjs/common';
import { ShipmentItemsController } from './shipment-items.controller';
import { ShipmentItemsService } from './shipment-items.service';

@Module({
  controllers: [ShipmentItemsController],
  providers: [ShipmentItemsService],
})
export class ShipmentItemsModule {}
