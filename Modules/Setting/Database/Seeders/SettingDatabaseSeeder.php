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
            'company_name' => 'Amrosab POS',
            'company_email' => 'support@www.amrosab.com',
            'company_phone' => '012345678901',
            'notification_email' => 'support@www.amrosab.com',
            'default_currency_id' => 1,
            'default_currency_position' => 'prefix',
            'footer_text' => 'LogixPos © 2022 || Developed by <strong><a target="_blank" href="www.amrosab.com/">HillsData Technologies</a></strong>',
            'company_address' => 'Nairobi, Kenya'
        ]);
    }
}
