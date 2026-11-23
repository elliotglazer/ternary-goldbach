$ErrorActionPreference = 'Stop'

# Research diagnostic. Integer assertions are exact. Floating output is illustrative.
$primeList = [System.Collections.Generic.List[int]]::new()
for ($candidate = 2; $candidate -le 2000; $candidate++) {
    $isPrime = $true
    for ($divisor = 2; $divisor * $divisor -le $candidate; $divisor++) {
        if ($candidate % $divisor -eq 0) { $isPrime = $false; break }
    }
    if ($isPrime) { $primeList.Add($candidate) }
}
$primorial = [System.Numerics.BigInteger]::One
foreach ($prime in $primeList) { $primorial *= $prime }
$cutoff = [System.Numerics.BigInteger]::Pow(2, 1000)
if ($primorial -le $cutoff) { throw 'Primorial cutoff failed' }

$poly = [System.Numerics.BigInteger]7 * 701 * 701 * 701 +
        [System.Numerics.BigInteger]61 * 701 * 701 + 96 * 701 + 384
$numerator = 185 * $poly
$denominator = [System.Numerics.BigInteger]::Pow(2, 250)
if ($numerator * [System.Numerics.BigInteger]::Pow(10, 60) -ge $denominator) {
    throw 'Exact 1e-60 budget comparison failed'
}

# Exact rational final comparison at the deliberately larger Mexpr bound 1.037001.
# t=1/2000, M=1037001/1000000, small=91/4 * 8/10^11.
$common = [System.Numerics.BigInteger]2000000000000
$finalNumerator = [System.Numerics.BigInteger]2001 * 1037001 * 1000 +
                  [System.Numerics.BigInteger]2001 * 91 * 40
$targetNumerator = [System.Numerics.BigInteger]10376 * ($common / 10000)
if ($finalNumerator -ge $targetNumerator) { throw 'Final minor bound failed' }

$logCutoffTwice = 1001 * [Math]::Log(2)
$plateau = 132 * $logCutoffTwice * $logCutoffTwice * [Math]::Pow(2, -250.25)
[pscustomobject]@{
    PrimeCountThrough2000 = $primeList.Count
    PrimorialExceedsCutoff = $true
    PlateauHeightApprox = $plateau
    ErrorBoundNumerator = $numerator.ToString()
    ErrorBoundDenominator = $denominator.ToString()
    ErrorBoundApprox = [double]$numerator / [double]$denominator
    ExactErrorBelow1eMinus60 = $true
    FinalMinorUpperApprox = [double]$finalNumerator / [double]$common
    ExactFinalMinorBelow1point0376 = $true
} | ConvertTo-Json
