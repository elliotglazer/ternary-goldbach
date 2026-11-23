$ErrorActionPreference = 'Stop'

# Exact arithmetic checks for the paper constants. No Lean compilation.
if ([decimal]5 * 5 * 40 -ge [decimal]40 * 40) { throw 'M1 square-root bound failed' }
if ([decimal]54 / [decimal]1224.99 -ge [decimal]0.05) { throw 'zeta3 bound failed' }
if ([decimal]6.0002 * [decimal]73.35 -ge [decimal]441) { throw 'Bridge third term failed' }
$assemblyCoefficient = [decimal]200 + 12 + [decimal]0.0717 +
                       [decimal]3191.9427 + [decimal]8465.1669 + 9
if ($assemblyCoefficient -ge 12000) { throw 'Assembly coefficient failed' }

$poly = [System.Numerics.BigInteger]7 * 350 * 350 * 350 +
        [System.Numerics.BigInteger]65 * 350 * 350 + 96 * 350 + 384
$numerator = 16800 * $poly
$denominator = [System.Numerics.BigInteger]::Pow(2, 125)
if ($numerator * [System.Numerics.BigInteger]::Pow(10, 24) -ge $denominator) {
    throw 'Exact H2 cost bound failed'
}

# Exact safety checks for the log ranges used in the b-case estimates.
if ([decimal]6000000 -le [decimal]1225 * 2792) { throw 'X/(8d)>1 failed' }
if ([decimal]6000000 -le [decimal]3 * 1225 * [decimal]99.68) { throw 'X/c>e failed' }
if ([decimal]32 -le [decimal]28 * (1 + [decimal]0.142451)) { throw '8d/c>28 failed' }

[pscustomobject]@{
    AssemblyCoefficient = $assemblyCoefficient
    H2ErrorNumerator = $numerator.ToString()
    H2ErrorDenominator = $denominator.ToString()
    H2ErrorApprox = [double]$numerator / [double]$denominator
    H2ErrorExactlyBelow1eMinus24 = $true
    WeakCoefficient = 12000
    WeakTExponent = '-1/4'
    CutoffT = '2^500'
    FiniteDenominatorCutoff = '2^1000'
} | ConvertTo-Json
