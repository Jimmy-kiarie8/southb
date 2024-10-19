<?php

namespace App\Http\Livewire;

use Livewire\Component;

class Transfer extends Component
{
    public function render()
    {
        return view('livewire.transfer');
    }

    public function selectLocation($data)
    {
        $this->emit('locationChange', $data);
    }
}
