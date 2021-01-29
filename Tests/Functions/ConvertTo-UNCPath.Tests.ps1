[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingComputerNameHardcoded', '', Scope='Function', Target='*')]
param ()

BeforeDiscovery {
    $cmdName = "ConvertTo-UNCPath"
}

BeforeAll {

    # Load Module if its not loaded.
    $cmdName = "ConvertTo-UNCPath"
    $moduleName = "SAM.Utilities"
    $modulePath = "$PSScriptRoot\..\..\output\$moduleName" | Convert-Path

    if (-Not(Get-Module -Name $moduleName)) { Import-Module $modulePath -Force }

    $command = Get-Command -Name $cmdName -All
    $help = Get-Help -Name $cmdName
    $verb = $command.Verb
    $ast = $command.ScriptBlock.Ast

}

Describe "$cmdName" {

    Context "Function Details" {

        It "Should use an approved Verb" { ( $verb -in @( Get-Verb ).Verb ) | Should -Be $true }

        It "[CmdletBinding()] should exist" {
            [boolean]( @( $ast.FindAll( { $true } , $true ) ) | Where-Object { $_.TypeName.Name -eq 'cmdletbinding' } ) | Should -Be $true
        }

        It "Should have Help Information" { $help | Should -Not -BeNullOrEmpty }

        It "Should have a Synopsis" { ( $command.ScriptBlock -match '.SYNOPSIS' ) | Should -Be $true }

        It "Should have a Description" {
            ([string]::IsNullOrEmpty($help.description.Text)) | Should -Be $false
        }

        It "Should have at least one example" { [boolean]( $help.examples ) | Should -Be $true }

    }

    Context "Function Actions" {

        It "Should be able to create UNC path" {
            $(ConvertTo-UNCPath -ComputerName "Computer1" -Path "C:\Temp") | Should -be "\\Computer1\C$\Temp"
        }

        It "Should be able to create multiple UNC paths" {
            $(ConvertTo-UNCPath -ComputerName "Computer1", "Computer2" -Path "C:\Temp").Count | Should -Be 2
        }
    }
}
