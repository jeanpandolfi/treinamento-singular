package br.com.basis.feriasmodule;

import br.com.basis.feriasmodule.flow.FeriasFlow;
import br.com.basis.feriasmodule.form.FeriasForm;
import br.com.basis.feriasmodule.box.FeriasCaixaPendencia;

import org.opensingular.requirement.commons.SingularRequirement;
import org.opensingular.requirement.module.FormFlowSingularRequirement;
import org.opensingular.requirement.module.RequirementConfiguration;
import org.opensingular.requirement.module.SingularModule;
import org.opensingular.requirement.module.WorkspaceConfiguration;
import org.opensingular.requirement.module.workspace.DefaultDonebox;
import org.opensingular.requirement.module.workspace.DefaultDraftbox;
import org.opensingular.requirement.module.workspace.DefaultInbox;
import org.opensingular.requirement.module.workspace.DefaultOngoingbox;

public class FeriasModule implements SingularModule {

    public static final String              FERIAS = "FERIAS";
    private             SingularRequirement ferias = new FormFlowSingularRequirement("Ferias", FeriasForm.class, FeriasFlow.class);

    @Override
    public String abbreviation() {
        return FERIAS;
    }

    @Override
    public String name() {
        return "Módulo Ferias";
    }

    @Override
    public void requirements(RequirementConfiguration config) {
        config
                .addRequirement(ferias);
    }

    @Override
    public void workspace(WorkspaceConfiguration config) {
        config
                .addBox(new DefaultDraftbox()).newFor(ferias)
                .addBox(new FeriasCaixaPendencia())
                .addBox(new DefaultInbox())
                .addBox(new DefaultOngoingbox())
                .addBox(new DefaultDonebox());
    }
}
