<?php

namespace App\Http\Livewire;

use Illuminate\Support\Facades\Log;
use Livewire\Component;
class TimeCounter extends Component
{
    public $time;
    protected $listeners = ['timeUpdated'];


    public function render()
    {
        return view('livewire.time-counter');
    }


    public function timeUpdated()
    {
        Log::debug(11111111111);
        $this->time = now();
    }

    public function mount()
    {
        $this->time = now();
    }
}
