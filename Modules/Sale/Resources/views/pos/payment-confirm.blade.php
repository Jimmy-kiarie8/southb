@extends('layouts.app')

@section('title', 'Create Sale')

@section('breadcrumb')
    <ol class="breadcrumb border-0 m-0">
        <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
        <li class="breadcrumb-item"><a href="{{ route('sales.index') }}">Sales</a></li>
        <li class="breadcrumb-item active">Add</li>
    </ol>
@endsection

@section('content')
<div class="container">
    <div class="card" style="width: 18rem;">
        <div class="card-body">
            <form id="paymentForm">
                @csrf <!-- Add CSRF token field -->
                <div class="mb-3">
                    <label for="exampleFormControlInput1" class="form-label">Phone</label>
                    <input type="text" class="form-control" id="exampleFormControlInput1" name="phone" placeholder="254...">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary mb-3">Confirm Payment</button>
                    <button type="button" id="checkPayment" class="btn btn-secondary mb-3">Check Payment</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@push('page_scripts')
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function(){
        $('#paymentForm').on('submit', function(e){
            e.preventDefault();
            var phone = $('#exampleFormControlInput1').val();
            var token = $('input[name="_token"]').val(); // Get the CSRF token
            var id = 6; // Assuming you have the ID from somewhere in your script or HTML

            $.ajax({
                url: '{{ route('app.pos.stk_push', '') }}/' + id,
                method: 'POST',
                data: {
                    phone: phone,
                    _token: token // Include the CSRF token
                },
                success: function(response){
                    // Handle the success response
                    alert('Payment request submitted successfully!');
                },
                error: function(xhr, status, error){
                    // Handle the error response
                    alert('An error occurred: ' + xhr.responseText);
                }
            });
        });

        $('#checkPayment').on('click', function(){
            var phone = $('#exampleFormControlInput1').val();
            var token = $('input[name="_token"]').val(); // Get the CSRF token
            var id = 6; // Assuming you have the ID from somewhere in your script or HTML

            $.ajax({
                url: '{{ route('app.pos.payment-check', '') }}/' + id,
                method: 'POST',
                data: {
                    phone: phone,
                    _token: token // Include the CSRF token
                },
                success: function(response){
                console.log("🚀 ~ $ ~ response:", response)
                    // Assuming the response contains a 'payment' boolean
                    if (response) {
                        window.location.href = '{{ route('sales.pos.pdf', '') }}/' + id;
                    } else {
                        alert('Payment not completed yet.');
                    }
                },
                error: function(xhr, status, error){
                    // Handle the error response
                    alert('An error occurred: ' + xhr.responseText);
                }
            });
        });
    });
</script>
@endpush
