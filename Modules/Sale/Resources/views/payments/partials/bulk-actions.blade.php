<div class="btn-group dropleft">
    <button type="button" class="btn btn-ghost-primary dropdown rounded" data-toggle="dropdown" aria-expanded="false">
        <i class="bi bi-three-dots-vertical"></i>
    </button>
    <div class="dropdown-menu">

        <a href="{{ route('sale-payments.bulkShow', $data->id) }}" class="dropdown-item">
            <i class="bi bi-eye mr-2 text-info" style="line-height: 1;"></i> Details
            </a>


            <button id="delete" class="dropdown-item" onclick="
                event.preventDefault();
                if (confirm('Are you sure? It will delete the data permanently!')) {
                document.getElementById('destroy{{ $data->id }}').submit()
                }">
                <i class="bi bi-trash mr-2 text-danger" style="line-height: 1;"></i> Reverse payment
                <form id="destroy{{ $data->id }}" class="d-none" action="{{ route('sale-payments.reversePayment', $data->id) }}" method="POST">
                    @csrf
                    @method('delete')
                </form>
            </button>
{{--
        @can('access_sale_payments')
            @if ($data->balance > 0)
                <a href="{{ route('sale-payments.bulkShow', 1) }}" class="dropdown-item">
                <i class="bi bi-eye mr-2 text-info" style="line-height: 1;"></i> Details
                </a>
            @endif
        @endcan --}}
        {{-- @can('edit_sales')
            <a href="{{ route('sale-payments.edit', [$data->sale->id, $data->id]) }}" class="dropdown-item">
                <i class="bi bi-pencil mr-2 text-primary" style="line-height: 1;"></i> Edit
            </a>
        @endcan
        @can('delete_sales')
            <button id="delete" class="dropdown-item" onclick="
                event.preventDefault();
                if (confirm('Are you sure? It will delete the data permanently!')) {
                document.getElementById('destroy{{ $data->id }}').submit()
                }">
                <i class="bi bi-trash mr-2 text-danger" style="line-height: 1;"></i> Delete
                <form id="destroy{{ $data->id }}" class="d-none" action="{{ route('sale-payments.destroy', $data->id) }}" method="POST">
                    @csrf
                    @method('delete')
                </form>
            </button>
        @endcan --}}
    </div>
</div>
