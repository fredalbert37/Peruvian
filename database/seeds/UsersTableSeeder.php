<?php

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('user')->insert([
            'business_id' => '1',
            'email' => 'abbost@gmail.com',
            'password' => bcrypt('abbost')
        ]);
    }
}
