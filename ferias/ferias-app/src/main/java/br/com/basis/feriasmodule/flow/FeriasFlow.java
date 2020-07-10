package br.com.basis.feriasmodule.flow;

import br.com.basis.feriasmodule.FeriasModule;
import org.opensingular.flow.core.DefinitionInfo;
import org.opensingular.flow.core.ITaskDefinition;
import org.opensingular.flow.core.FlowInstance;
import org.opensingular.flow.core.defaults.PermissiveTaskAccessStrategy;

import org.opensingular.requirement.commons.flow.builder.RequirementFlowBuilder;
import org.opensingular.requirement.commons.flow.builder.RequirementFlowDefinition;
import org.opensingular.requirement.commons.wicket.view.form.FormPage;


import javax.annotation.Nonnull;

import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.ANALISAR;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.APROVADO;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.REPROVADO;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.SOLICITACAO_COM_PENDENCIAS;

@DefinitionInfo("ferias")
public class FeriasFlow extends RequirementFlowDefinition<FlowInstance> {

    public enum FeriasTasks implements ITaskDefinition {

        ANALISAR("Analisar"),
        APROVADO("Aprovado"),
        REPROVADO("Reprovado"),
        SOLICITACAO_COM_PENDENCIAS("Solicitação com pendências");

        private String taskName;

        FeriasTasks(String taskName) {
            this.taskName = taskName;
        }

        @Override
        public String getName() {
            return taskName;
        }
    }

    public FeriasFlow() {
        super(FlowInstance.class);
        this.setName(FeriasModule.FERIAS, "Ferias");

    }

    @Override
    protected void buildFlow(@Nonnull RequirementFlowBuilder flow) {

        flow.addHumanTask(ANALISAR)
                .uiAccess(new PermissiveTaskAccessStrategy()).withExecutionPage(FormPage.class);

        flow.addHumanTask(SOLICITACAO_COM_PENDENCIAS).uiAccess(new PermissiveTaskAccessStrategy())
                .withExecutionPage(FormPage.class);

        flow.addEndTask(REPROVADO);
        flow.addEndTask(APROVADO);

        flow.setStartTask(ANALISAR);

        flow.from(ANALISAR).go("Solicitar ajustes", SOLICITACAO_COM_PENDENCIAS);
        flow.from(ANALISAR).go("Aprovar", APROVADO);
        flow.from(ANALISAR).go("Reprovar", REPROVADO);

        flow.from(SOLICITACAO_COM_PENDENCIAS).go("Concluir Pendência", ANALISAR);
    }


}