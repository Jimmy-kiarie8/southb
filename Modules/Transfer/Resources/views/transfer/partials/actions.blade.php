@can('access_sale_payments')

@endcan
@can('show_transfer')
<a href="{{ route('transfer.show', $data->reference) }}" class="btn btn-primary btn-sm">
    <i class="bi bi-eye"></i>
</a>
@endcan
