require 'win32ole'

ps = WIN32OLE.connect("winmgmts:\\\\.")
ps.InstancesOf("win32_process").each do |p|
  puts "Process: #{p.name}"
  puts "\tID: #{p.processid}"
  puts "\tPATH:#{p.executablepath}"
  puts "\tTHREADS: #{p.threadcount}"
  puts "\tPRIORITY: #{p.priority}"
  puts "\tCMD_ARGS: #{p.commandline}"
end


#you can use any of the following properties

# Caption
# CommandLine
# CreationClassName
# CreationDate
# CSCreationClassName
# CSName
# Description
# ExecutablePath
# ExecutionState
# Handle
# HandleCount
# InstallDate
# KernelModeTime
# MaximumWorkingSetSize
# MinimumWorkingSetSize
# Name
# OSCreationClassName
# OSName
# OtherOperationCount
# OtherTransferCount
# PageFaults
# PageFileUsage
# ParentProcessId
# PeakPageFileUsage
# PeakVirtualSize
# PeakWorkingSetSize
# Priority
# PrivatePageCount
# ProcessId
# QuotaNonPagedPoolUsage
# QuotaPagedPoolUsage
# QuotaPeakNonPagedPoolUsage
# QuotaPeakPagedPoolUsage
# ReadOperationCount
# ReadTransferCount
# SessionId
# Status
# TerminationDate
# ThreadCount
# UserModeTime
# VirtualSize
# WindowsVersion
# WorkingSetSize
# WriteOperationCount
# WriteTransferCount
