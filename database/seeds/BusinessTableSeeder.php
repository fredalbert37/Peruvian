<?php

use Illuminate\Database\Seeder;

class BusinessTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('business')->insert([
            'ruc' => '20456754831',
            'name' => 'peruvianGift',
            'Telephone_one' =>'950562098'
        ]);
    }
}
