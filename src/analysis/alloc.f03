subroutine alloca(this)
    class(intData), intent(inout) :: this
    allocate(this%avgInteraction(this%size))
    allocate(this%avgEnergyGap(this%size))
    allocate(this%varEnergyGap(this%size))
    allocate(this%topEnergyGap(this%size))
    allocate(this%bottomEnergyGap(this%size))    
end subroutine alloca