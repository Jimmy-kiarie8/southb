<?php

namespace Modules\Product\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Product\Entities\Product;
use Illuminate\Support\Str;

class ProductDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Model::unguard();

        $faker = \Faker\Factory::create();

        $faker->addProvider(new \Bezhanov\Faker\Provider\Commerce($faker));



        foreach (range(1, 30) as $index) {
            $barcode = Str::random(7);
            $price = $faker->numberBetween(1000, 90000);
            $product = Product::create([
                'product_name' => $faker->productName,
                'product_code' => $barcode,
                'product_barcode_symbology' => $barcode,
                'product_quantity' => $faker->numberBetween(50, 900),
                'product_cost' => $faker->numberBetween(1000, 90000),
                'product_price' => $price,
                'product_unit' => $price - 100,
                'product_stock_alert' => 50,
                'category_id' => $faker->numberBetween(1, 6),
                'product_note' => $faker->text
            ]);
        }

        // $this->call("OthersTableSeeder");
    }
}
