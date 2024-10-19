<?php

namespace App\Console\Commands;

use Carbon\Carbon;
use Exception;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;

class BackupDatabase extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'backup:database';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Run backup (mysqldump) on database and upload to S3';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        try {
            $database = env('DB_DATABASE');
            $filename   = env('APP_NAME') . "-" . Carbon::now()->format('Y-m-d_H-i-s') . ".gz";
            $return_var = NULL;
            $output     = NULL;
            $command    = "mysqldump --user=" . env('DB_USERNAME') . " --password=" . env('DB_PASSWORD') . " --host=" . env('DB_HOST') . " " . $database . "  | gzip > " . public_path() . '/storage/' . $filename;

            exec($command, $output, $return_var);

            if (!$return_var) {
                // $getFile = Storage::disk('public')->put('products', $img);
                $getFile = Storage::disk('tenant')->get($filename);
                if ($getFile !== null) {
                    Storage::disk('google')->put($filename, $getFile);
                    Storage::disk('tenant')->delete($filename);
                    $this->info($filename . ' Backup complete');
                } else {
                    $this->info('File not found');
                    // Handle the case when $getFile is null
                    // You can log an error or take appropriate action
                }
            } else {
                Mail::raw('There has been an error backing up the database.', function ($message) {
                    $message->to(env('ADMIN_MAIL', env('ADMIN_MAIL', 'support@test.com')), "test")->subject("Backup Error");
                });
            }
        } catch (Exception $e) {
            // dd($e);
            Mail::raw('There has been an error backing up the database.', function ($message) {
                $message->to(env('ADMIN_MAIL', env('ADMIN_MAIL', 'support@test.com')), "test")->subject("Backup Error");
            });
        }
    }
}
