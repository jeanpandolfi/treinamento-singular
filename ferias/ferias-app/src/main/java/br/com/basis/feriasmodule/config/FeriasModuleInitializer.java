package br.com.basis.feriasmodule.config;

import org.opensingular.requirement.studio.init.RequirementStudioAppInitializer;

public class FeriasModuleInitializer implements RequirementStudioAppInitializer {

    @Override
    public String moduleCod() {
        return "FERIAS";
    }

    @Override
    public String[] springPackagesToScan() {
        return new String[]{"br.com.basis"};
    }

}
