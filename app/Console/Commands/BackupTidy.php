<?php

namespace App\Console\Commands;

use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;

class BackupTidy extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'backup:tidy';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Remove backup files that are over one month old.';

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
        $files = Storage::disk('google')->files();

        foreach($files as $file){

            $modified = Storage::disk('google')->lastModified($file);
            $date     = Carbon::createFromTimestampUTC($modified);

            if($date < Carbon::now()->subWeeks(2)){
                Storage::disk('google')->delete($file);
                $this->info("Deleted " . $file);
            }

        }
        
    }
}