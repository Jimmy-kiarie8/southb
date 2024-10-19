<?php

namespace App\Console\Commands;

use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class BackupRestore extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'backup:restore {path}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Restore Database backup';

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
        $tenant = tenant('id');
        $database = config('tenancy.database.prefix') . $tenant;
        $dir = '/';
        $recursive = false; // Get subdirectories also?
        $contents = collect(Storage::cloud()->listContents($dir, $recursive));

        foreach ($contents as $key => $value) {
            $arr = explode('-', $value['name']);
            if ($arr[0] != $tenant) {
                unset($contents[$key]);
            }
        }
        /* $collection = $contents->reject(function($element) use ($tenant) {
            return mb_strpos($element['name'], $tenant) === false;
        }); */
        // dd($contents);
        //return $contents->where('type', '=', 'dir'); // directories
        $files = $contents->where('type', '=', 'file'); // files
        // $files = Storage::disk('google')->allFiles();

        $i = 0;
        foreach ($files as $key => $file) {
            // dd( $file['filename']);

            $filename[$i]['filename'] = $file['name'];
            $filename[$i]['path'] = $file['path'];
            $filename[$i]['Backup Date'] = Carbon::createFromTimestamp($file['timestamp'])->diffForHumans();
            $i++;
        }
        // dd($filename);


        $headers = ['File Name', 'Path', 'Time'];
        $this->table($headers, $filename);

        // dd('yeyeyeye');
       /*  dd($this->arguments('path'));
        $tenant = tenant('id');
        $database = config('tenancy.database.prefix') . $tenant; */
        // $backupFilename = $this->ask('Which file would you like to restore? paste the path');


        // dd($backupFilename);

        // $getBackupPath  = Storage::disk('google')->path($backupFilename);
        $backupFilename = $this->option('path');

        $getBackupFile = Storage::disk('google')->get($backupFilename);

        // $backupFilename  = explode("/", $backupFilename);
        // $backupFilename = $backupFilename . '.sql.gz';

        // dd($getBackupFile);

        Storage::disk('tenant')->put($backupFilename, $getBackupFile);

        $mime = Storage::disk('tenant')->mimeType($backupFilename);
        // $mime = $filename[0]['mime'];
        // dd($mime);

        if ($mime == "application/x-gzip" || $mime == "application/gzip") {
            Log::debug(public_path() . "/storage/" . $backupFilename);

            $command = "zcat " . public_path() . "/storage/" . $backupFilename . " | mysql --user=" . env('DB_USERNAME') . " --password=" . env('DB_PASSWORD') . " --host=" . env('DB_HOST') . " " . $database . "";
        } elseif ($mime == "text/plain") {
            Log::debug("2");
            Log::debug(public_path() . "/storage/" . $backupFilename);

            $command = "mysql --user=" . env('DB_USERNAME') . " --password=" . env('DB_PASSWORD') . " --host=" . env('DB_HOST') . " " . $database . " < " . public_path() . "/storage/" . $backupFilename;
        } else {

            $this->error("File is not gzip or plain text");
            Storage::disk('tenant')->delete($backupFilename);
            return false;
        }

        if ($this->confirm("Are you sure you want to restore the database? [y|N]")) {

            $returnVar  = NULL;
            $output     = NULL;
            exec($command, $output, $returnVar);

            Storage::disk('tenant')->delete($backupFilename);

            if (!$returnVar) {
                $this->info('Database Restored');
            } else {

                $this->error('Error ' . $returnVar);
            }
        }
        $this->info('Restore complete');
    }
}
