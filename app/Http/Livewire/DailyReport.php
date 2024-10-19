<?php

namespace App\Http\Livewire;

use Illuminate\Support\Facades\DB;
use Livewire\Component;
use Livewire\WithPagination;
use Modules\Sale\Entities\Sale;
use Modules\Sale\Entities\SalePayment;

class DailyReport extends Component
{
    use WithPagination;
    protected $paginationTheme = 'bootstrap';

    public $start_date;
    public $end_date;
    public $user_id;


    protected $rules = [
        'start_date' => 'required|date|before:end_date',
        'end_date'   => 'required|date|after:start_date',
    ];

    public function mount()
    {
        // $this->start_date = today()->subDays(30)->format('Y-m-d');
        $this->start_date = today()->format('Y-m-d');
        $this->end_date = today()->format('Y-m-d');
        $this->user_id = null;
    }


    public function generateReport()
    {
        // $this->validate();
        $this->render();
    }

    public function render()
    {
        // dd($this->user_id);
        // $sales = SalePayment::when($this->user_id, function ($query) {
        //         return $query->where('user_id', $this->user_id);
        //     })
        //     ->orderBy('date', 'desc')->paginate(10);

        $results = DB::table('sale_payments');

        $sales = new SalePayment;
        // $count = SalePayment::whereDate('created_at', today())->sum('amount');

        if ($this->start_date && $this->end_date) {
            $sales = $sales->whereBetween('date', [$this->start_date, $this->end_date]);
            $results = $results->whereBetween('date', [$this->start_date, $this->end_date]);
        } else {
            $sales = $sales->whereDate('date', today());
            $results = $results->whereDate('date', today());
        }
        $sales_arr = [];
        if ($this->user_id) {
            $sales_arr = Sale::where('user_id', $this->user_id)->pluck('id');
        }

        $sales = $sales->when(($sales_arr), function ($q) use($sales_arr) {
            return $q->whereIn('sale_id', $sales_arr);
        })->paginate(10);

        $results = $results->when(($sales_arr), function ($q) use($sales_arr) {
            return $q->whereIn('sale_id', $sales_arr);
        })->select('payment_method', DB::raw('SUM(amount) as total'))
                ->groupBy('payment_method')
                ->get();

        // $total =SalePayment::distinct('payment_method')
        //     ->pluck('payment_method')
        //     ->sum('amount');
        return view('livewire.reports.daily-report', [
            'sales' => $sales,
            'results' => $results
        ]);
    }
}
