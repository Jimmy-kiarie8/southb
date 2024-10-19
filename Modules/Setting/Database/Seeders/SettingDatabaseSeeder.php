<?php

namespace Modules\Setting\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Setting\Entities\Setting;

class SettingDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Setting::create([
            'company_name' => 'Hills Data Technologies POS',
            'company_email' => 'support@hillsdatatechnologies.co.ke',
            'company_phone' => '012345678901',
            'notification_email' => 'support@hillsdatatechnologies.co.ke',
            'default_currency_id' => 1,
            'default_currency_position' => 'prefix',
            'footer_text' => 'LogixPos © 2022 || Developed by <strong><a target="_blank" href="https://hillsdatatechnologies.co.ke/">HillsData Technologies</a></strong>',
            'company_address' => 'Nairobi, Kenya'
        ]);
    }
}
