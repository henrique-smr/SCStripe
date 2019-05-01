subroutine dealloca(this)
    class(intData), intent(inout)   :: this
    deallocate(this%bottomEnergyGap)
    deallocate(this%avgInteraction)
    deallocate(this%avgEnergyGap)
    deallocate(this%varEnergyGap)
    deallocate(this%topEnergyGap)
end subroutine