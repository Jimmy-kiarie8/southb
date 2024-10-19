@if ($data->status == 'Unpaid')
    <span class="badge badge-danger">
        {{ $data->status }}
    </span>
@elseif ($data->status == 'Paid')
    <span class="badge badge-success">
        {{ $data->status }}
    </span>
@elseif ($data->status == 'Partially paid')
<span class="badge badge-primary">
    {{ $data->status }}
</span>
@else
    <span class="badge badge-success">
        {{ $data->status }}
    </span>
@endif
