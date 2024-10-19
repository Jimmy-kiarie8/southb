<div wire:poll>
    The current time is: {{ $time->format('h:i:s a') }}
</div>

@push('page_scripts')
<script>
    setInterval(() => {
        console.log('Event emitted');
        Livewire.emit('timeUpdated');
    }, 1000)();
</script>


@endpush
