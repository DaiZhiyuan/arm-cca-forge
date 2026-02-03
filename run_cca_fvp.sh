#!/bin/bash

# Exit on error.
set -e

# Execute prerun commands.
SEMIHOSTDIR=`mktemp -d`
function finish { rm -rf $SEMIHOSTDIR; }
trap finish EXIT
cp Image ${SEMIHOSTDIR}/Image
cp dt_bootargs.dtb ${SEMIHOSTDIR}/fdt.dtb
cat <<EOF > ${SEMIHOSTDIR}/startup.nsh
Image dtb=fdt.dtb mem=1G earlycon nokaslr root=/dev/vda ip=dhcp acpi=force
EOF

# Run the model.
FVP_Base_RevC-2xAEMvA \
    --stat \
    -C bp.dram_metadata.is_enabled=1 \
    -C bp.dram_size=4 \
    -C bp.flashloader0.fname=fip.bin \
    -C bp.flashloader1.fname= \
    -C bp.has_rme=1 \
    -C bp.refcounter.non_arch_start_at_default=1 \
    -C bp.secure_memory=0 \
    -C bp.secureflashloader.fname=bl1.bin \
    -C bp.smsc_91c111.enabled=1 \
    -C bp.terminal_0.mode=telnet \
    -C bp.terminal_0.terminal_command="xterm -title 'UART0' -e telnet localhost %port" \
    -C bp.terminal_1.mode=telnet \
    -C bp.terminal_1.terminal_command="xterm -title 'UART1' -e telnet localhost %port" \
    -C bp.terminal_2.mode=telnet \
    -C bp.terminal_2.terminal_command="xterm -title 'UART2' -e telnet localhost %port" \
    -C bp.terminal_3.mode=telnet \
    -C bp.terminal_3.terminal_command="xterm -title 'UART3' -e telnet localhost %port" \
    -C bp.ve_sysregs.exit_on_shutdown=1 \
    -C bp.virtio_rng.enabled=1 \
    -C bp.virtioblockdevice.image_path=rootfs.ext2 \
    -C bp.virtiop9device.root_path= \
    -C bp.vis.disable_visualisation=1 \
    -C cache_state_modelled=0 \
    -C cluster0.NUM_CORES=4 \
    -C cluster0.PA_SIZE=48 \
    -C cluster0.brbe_disable_recording=1 \
    -C cluster0.check_memory_attributes=0 \
    -C cluster0.clear_reg_top_eret=2 \
    -C cluster0.cpu0.semihosting-cwd=${SEMIHOSTDIR} \
    -C cluster0.ecv_support_level=2 \
    -C cluster0.enhanced_pac2_level=3 \
    -C cluster0.gicv3.cpuintf-mmap-access-level=2 \
    -C cluster0.gicv3.extended-interrupt-range-support=1 \
    -C cluster0.gicv3.without-DS-support=1 \
    -C cluster0.gicv4.mask-virtual-interrupt=1 \
    -C cluster0.has_16k_granule=1 \
    -C cluster0.has_amu=1 \
    -C cluster0.has_arm_v8-1=1 \
    -C cluster0.has_arm_v8-2=1 \
    -C cluster0.has_arm_v8-3=1 \
    -C cluster0.has_arm_v8-4=1 \
    -C cluster0.has_arm_v8-5=1 \
    -C cluster0.has_arm_v8-6=1 \
    -C cluster0.has_arm_v8-7=1 \
    -C cluster0.has_arm_v9-0=1 \
    -C cluster0.has_arm_v9-1=1 \
    -C cluster0.has_arm_v9-2=1 \
    -C cluster0.has_branch_target_exception=1 \
    -C cluster0.has_brbe=1 \
    -C cluster0.has_large_system_ext=1 \
    -C cluster0.has_large_va=1 \
    -C cluster0.has_rndr=1 \
    -C cluster0.has_sve=1 \
    -C cluster0.max_32bit_el=0 \
    -C cluster0.memory_tagging_support_level=2 \
    -C cluster0.output_attributes=ExtendedID[62:55]=MPAM_PMG,ExtendedID[54:39]=MPAM_PARTID,ExtendedID[38:37]=MPAM_SP \
    -C cluster0.restriction_on_speculative_execution=2 \
    -C cluster0.restriction_on_speculative_execution_aarch32=2 \
    -C cluster0.rme_support_level=2 \
    -C cluster0.stage12_tlb_size=1024 \
    -C cluster0.sve.has_sme=1 \
    -C cluster0.sve.has_sve2=1 \
    -C cluster1.NUM_CORES=4 \
    -C cluster1.PA_SIZE=48 \
    -C cluster1.brbe_disable_recording=1 \
    -C cluster1.check_memory_attributes=0 \
    -C cluster1.clear_reg_top_eret=2 \
    -C cluster1.ecv_support_level=2 \
    -C cluster1.enhanced_pac2_level=3 \
    -C cluster1.gicv3.cpuintf-mmap-access-level=2 \
    -C cluster1.gicv3.extended-interrupt-range-support=1 \
    -C cluster1.gicv3.without-DS-support=1 \
    -C cluster1.gicv4.mask-virtual-interrupt=1 \
    -C cluster1.has_16k_granule=1 \
    -C cluster1.has_amu=1 \
    -C cluster1.has_arm_v8-1=1 \
    -C cluster1.has_arm_v8-2=1 \
    -C cluster1.has_arm_v8-3=1 \
    -C cluster1.has_arm_v8-4=1 \
    -C cluster1.has_arm_v8-5=1 \
    -C cluster1.has_arm_v8-6=1 \
    -C cluster1.has_arm_v8-7=1 \
    -C cluster1.has_arm_v9-0=1 \
    -C cluster1.has_arm_v9-1=1 \
    -C cluster1.has_arm_v9-2=1 \
    -C cluster1.has_branch_target_exception=1 \
    -C cluster1.has_brbe=1 \
    -C cluster1.has_large_system_ext=1 \
    -C cluster1.has_large_va=1 \
    -C cluster1.has_rndr=1 \
    -C cluster1.has_sve=1 \
    -C cluster1.max_32bit_el=0 \
    -C cluster1.memory_tagging_support_level=2 \
    -C cluster1.output_attributes=ExtendedID[62:55]=MPAM_PMG,ExtendedID[54:39]=MPAM_PARTID,ExtendedID[38:37]=MPAM_SP \
    -C cluster1.restriction_on_speculative_execution=2 \
    -C cluster1.restriction_on_speculative_execution_aarch32=2 \
    -C cluster1.rme_support_level=2 \
    -C cluster1.stage12_tlb_size=1024 \
    -C cluster1.sve.has_sme=1 \
    -C cluster1.sve.has_sve2=1 \
    -C gic_distributor.ARE-fixed-to-one=1 \
    -C gic_distributor.extended-ppi-count=64 \
    -C gic_distributor.extended-spi-count=1024 \
    -C pci.pci_smmuv3.mmu.SMMU_AIDR=2 \
    -C pci.pci_smmuv3.mmu.SMMU_IDR0=135263935 \
    -C pci.pci_smmuv3.mmu.SMMU_IDR1=216481056 \
    -C pci.pci_smmuv3.mmu.SMMU_IDR3=5908 \
    -C pci.pci_smmuv3.mmu.SMMU_IDR5=4294902901 \
    -C pci.pci_smmuv3.mmu.SMMU_ROOT_IDR0=3 \
    -C pci.pci_smmuv3.mmu.SMMU_ROOT_IIDR=1083 \
    -C pci.pci_smmuv3.mmu.SMMU_S_IDR1=2684354562 \
    -C pci.pci_smmuv3.mmu.SMMU_S_IDR2=0 \
    -C pci.pci_smmuv3.mmu.SMMU_S_IDR3=0 \
    -C pci.pci_smmuv3.mmu.root_register_page_offset=131072 \
    -C pctl.startup=0.0.0.0
