<?php

namespace Modules\Quotation\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Modules\Quotation\Emails\LpoMail;
use Modules\Quotation\Emails\QuotationMail;
use Modules\Quotation\Entities\Lpo;
use Modules\Quotation\Entities\Quotation;

class SendLpoEmailController extends Controller
{
    public function __invoke(Lpo $lpo) {
        try {
            Mail::to($lpo->supplier->supplier_email)->send(new LpoMail($lpo));

            $lpo->update([
                'status' => 'Sent'
            ]);

            toast('Sent On "' . $lpo->supplier->supplier_email . '"!', 'success');

        } catch (\Exception $exception) {
            Log::error($exception);
            toast('Something Went Wrong!', 'error');
        }

        return back();
    }
}
