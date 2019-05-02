
module Analysis
    use crystalBase
    implicit none
    type :: intData
        type(crystal)       :: crystal        
        real*8, allocatable :: bottomEnergyGap(:)
        real*8, allocatable :: topEnergyGap   (:)
        real*8, allocatable :: avgInteraction (:)
        real*8, allocatable :: avgEnergyGap   (:)
        real*8, allocatable :: varEnergyGap   (:)
        integer             :: size
    contains
        procedure, public         :: set_analysis_data
        procedure, public         :: printVeff
        procedure, public         :: standartPrint
        procedure, public         :: detailPrint
        procedure, public         :: export_analysis
        procedure, public         :: closeData
    !------------------------------------------------------
        procedure, private        :: analize_fix_ord
        procedure, private        :: analize_fix_level
        procedure, private         :: alloca
        procedure, private         :: dealloca
    !----------------------------------------------------
    end type intData    


contains
    
#include <../src/analysis/set_analysis_data.f03>

#include <../src/analysis/analize_fix_ord.f03>

#include <../src/analysis/analize_fix_level.f03>

#include <../src/analysis/printVeff.f03>

#include <../src/analysis/standartPrint.f03>

#include <../src/analysis/detailPrint.f03>

#include <../src/analysis/export_analysis.f03>

#include <../src/analysis/closeData.f03>

#include <../src/analysis/alloc.f03>

#include <../src/analysis/dealloc.f03>


end module Analysis