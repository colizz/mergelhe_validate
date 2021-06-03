#!/bin/bash
set -x

# git clone
export VALDIR="mergelhe_validate"
export LOCALDIR="testarea"
export OUTDIR="$VALDIR/output"

if [ ! -d "$VALDIR" ]; then
    git clone 123
fi
if [ -d "$LOCALDIR" ]; then
    rm -r $LOCALDIR
fi
mkdir $LOCALDIR

# Test simple MG LO LHEs
./mergeLHE.py -i 'mergelhe_validate/lhes/mglo/*.lhe' -o $LOCALDIR/out_mglo.lhe; \
    diff $LOCALDIR/out_mglo.lhe $OUTDIR/out_mglo.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/mglo/*.lhe' -o $LOCALDIR/out_mglo_mglomerger.lhe --force-mglo-merger; \
    diff $LOCALDIR/out_mglo_mglomerger.lhe $OUTDIR/out_mglo_mglomerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/mglo/*.lhe' -o $LOCALDIR/out_mglo_cppmerger.lhe --force-cpp-merger; \
    diff $LOCALDIR/out_mglo_cppmerger.lhe $OUTDIR/out_mglo_cppmerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/mglo/*.lhe' -o $LOCALDIR/out_mglo_bypass.lhe -b; \
    diff $LOCALDIR/out_mglo_bypass.lhe $OUTDIR/out_mglo_bypass.lhe | head -n 100

# Test complicated MG LO LHEs
./mergeLHE.py -i 'mergelhe_validate/lhes/mglocompl/*.lhe' -o $LOCALDIR/out_mglocompl.lhe; \
    diff $LOCALDIR/out_mglo_mglomergeout_mglocomplr.lhe $OUTDIR/out_mglo_mout_mglocomplglomerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/mglocompl/*.lhe' -o $LOCALDIR/out_mglocompl_mglomerger.lhe --force-mglo-merger; \
    diff $LOCALDIR/out_mglocompl_mglomerger.lhe $OUTDIR/out_mglocompl_mglomerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/mglocompl/*.lhe' -o $LOCALDIR/out_mglocompl_cppmerger.lhe --force-cpp-merger; \
    diff $LOCALDIR/out_mglocompl_cppmerger.lhe $OUTDIR/out_mglocompl_cppmerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/mglocompl/*.lhe' -o $LOCALDIR/out_mglocompl_bypass.lhe -b; \
    diff $LOCALDIR/out_mglocompl_bypass.lhe $OUTDIR/out_mglocompl_bypass.lhe | head -n 100

# Below tests are for non-MG-LO LHE so we cannot use --force-mglo-merger
# Test MG NLO LHEs
# default and -b gives the same result; cpp merger cannot read the 2nd file due to its special <event ...> block format
./mergeLHE.py -i 'mergelhe_validate/lhes/mgnlo/*.lhe' -o $LOCALDIR/out_mgnlo.lhe; \
    diff $LOCALDIR/out_mgnlo.lhe $OUTDIR/out_mgnlo.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/mgnlo/*.lhe' -o $LOCALDIR/out_mgnlo_cppmerger.lhe --force-cpp-merger; \
    diff $LOCALDIR/out_mgnlo_cppmerger.lhe $OUTDIR/out_mgnlo_cppmerger.lhe | head -n 100 # gives false result!
./mergeLHE.py -i 'mergelhe_validate/lhes/mgnlo/*.lhe' -o $LOCALDIR/out_mgnlo_bypass.lhe -b; \
    diff $LOCALDIR/out_mgnlo_bypass.lhe $OUTDIR/out_mgnlo_bypass.lhe | head -n 100

# Test on powheg LHEs
./mergeLHE.py -i 'mergelhe_validate/lhes/pow/*.lhe' -o $LOCALDIR/out_pow.lhe; \
    diff $LOCALDIR/out_pow.lhe $OUTDIR/out_pow.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/pow/*.lhe' -o $LOCALDIR/out_pow_cppmerger.lhe --force-cpp-merger; \
    diff $LOCALDIR/out_pow_cppmerger.lhe $OUTDIR/out_pow_cppmerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/pow/*.lhe' -o $LOCALDIR/out_pow_bypass.lhe -b; \
    diff $LOCALDIR/out_pow_bypass.lhe $OUTDIR/out_pow_bypass.lhe | head -n 100

# Test on another set of powheg LHEs
./mergeLHE.py -i 'mergelhe_validate/lhes/ppow/*.lhe' -o $LOCALDIR/out_ppow.lhe; \
    diff $LOCALDIR/out_ppow.lhe $OUTDIR/out_ppow.lhe | head -n 100  # this fails! Unmatched header for the two inputs
./mergeLHE.py -i 'mergelhe_validate/lhes/ppow/*.lhe' -o $LOCALDIR/out_ppow_cppmerger.lhe --force-cpp-merger; \
    diff $LOCALDIR/out_ppow_cppmerger.lhe $OUTDIR/out_ppow_cppmerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/ppow/*.lhe' -o $LOCALDIR/out_ppow_bypass.lhe -b; \
    diff $LOCALDIR/out_ppow_bypass.lhe $OUTDIR/out_ppow_bypass.lhe | head -n 100

# Test on JHUGen LHEs
./mergeLHE.py -i 'mergelhe_validate/lhes/jhugen/*.lhe' -o $LOCALDIR/out_jhugen.lhe; \
    diff $LOCALDIR/out_jhugen.lhe $OUTDIR/out_jhugen.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/jhugen/*.lhe' -o $LOCALDIR/out_jhugen_cppmerger.lhe --force-cpp-merger; \
    diff $LOCALDIR/out_jhugen_cppmerger.lhe $OUTDIR/out_jhugen_cppmerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/jhugen/*.lhe' -o $LOCALDIR/out_jhugen_bypass.lhe -b; \
    diff $LOCALDIR/out_jhugen_bypass.lhe $OUTDIR/out_jhugen_bypass.lhe | head -n 100

# Test on JHUGen V7011 LHEs 
./mergeLHE.py -i 'mergelhe_validate/lhes/jhu7011/*.lhe' -o $LOCALDIR/out_jhu7011.lhe; \
    diff $LOCALDIR/out_jhu7011.lhe $OUTDIR/out_jhu7011.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/jhu7011/*.lhe' -o $LOCALDIR/out_jhu7011_cppmerger.lhe --force-cpp-merger; \
    diff $LOCALDIR/out_jhu7011_cppmerger.lhe $OUTDIR/out_jhu7011_cppmerger.lhe | head -n 100
./mergeLHE.py -i 'mergelhe_validate/lhes/jhu7011/*.lhe' -o $LOCALDIR/out_jhu7011_bypass.lhe -b; \
    diff $LOCALDIR/out_jhu7011_bypass.lhe $OUTDIR/out_jhu7011_bypass.lhe | head -n 100
