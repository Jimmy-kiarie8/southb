<?php

namespace Modules\Product\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use Modules\Product\Entities\Category;

class CategoryDatabaseSeeder extends Seeder
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

        foreach (range(1, 7) as $index) {
            $category = Category::create([
                'category_code' => $faker->department,
                'category_name' => $faker->department
            ]);
        }
    }
}
