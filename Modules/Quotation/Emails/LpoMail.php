<?php

namespace Modules\Quotation\Emails;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class LpoMail extends Mailable
{
    use Queueable, SerializesModels;

    public $lpo;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($lpo)
    {
        $this->lpo = $lpo;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject('LPO - ' . settings()->company_name)
            ->view('quotation::lpo.emails.lpo', [
                'settings' => settings(),
                'customer' => $this->lpo->supplier
            ]);
    }
}
