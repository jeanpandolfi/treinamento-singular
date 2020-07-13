package br.com.basis.feriasmodule.flow;

/*                                                        -> APROVADO
 * SOLICITAÇÃO DE DFERIAS -> ANALISE CHEFIA -> ANALISE RH 
 * 	                                                      -> REPROVADO
 * */
import br.com.basis.feriasmodule.FeriasModule;
import org.opensingular.flow.core.DefinitionInfo;
import org.opensingular.flow.core.ITaskDefinition;
import org.opensingular.flow.core.FlowInstance;
import org.opensingular.flow.core.defaults.PermissiveTaskAccessStrategy;

import org.opensingular.requirement.commons.flow.builder.RequirementFlowBuilder;
import org.opensingular.requirement.commons.flow.builder.RequirementFlowDefinition;
import org.opensingular.requirement.commons.wicket.view.form.FormPage;


import javax.annotation.Nonnull;

import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.DECISAO_ANTECIPACAO_13;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.ANALISE_RH;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.ANALISE_DIRETOR;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.ANALISE_CHEFIA;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.APROVADO;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.REPROVADO;
import static br.com.basis.feriasmodule.flow.FeriasFlow.FeriasTasks.SOLICITACAO_COM_PENDENCIAS;

@DefinitionInfo("ferias")
public class FeriasFlow extends RequirementFlowDefinition<FlowInstance> {
	
	public static final String ENVIAR_DIRETOR = "Enviar para Diretor";
	public static final String ENVIAR_RH = "Enviar para RH";
	
    public enum FeriasTasks implements ITaskDefinition {

        ANALISE_CHEFIA("Analise da Chefia"),
        DECISAO_ANTECIPACAO_13("Encaminhar"),
        ANALISE_DIRETOR("Análise do Diretor"),
        ANALISE_RH("Análise do RH"),
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
    	//Definção das tarefas
        flow.addHumanTask(ANALISE_CHEFIA)
                .uiAccess(new PermissiveTaskAccessStrategy()).withExecutionPage(FormPage.class);
        
        flow.addJavaTask(DECISAO_ANTECIPACAO_13).call(new DecisaoAnaliseDiretor());
        
        flow.addHumanTask(ANALISE_DIRETOR)
        		.uiAccess(new PermissiveTaskAccessStrategy()).withExecutionPage(FormPage.class);
        
        flow.addHumanTask(ANALISE_RH)
				.uiAccess(new PermissiveTaskAccessStrategy()).withExecutionPage(FormPage.class);

        flow.addHumanTask(SOLICITACAO_COM_PENDENCIAS).uiAccess(new PermissiveTaskAccessStrategy())
                .withExecutionPage(FormPage.class);

        flow.addEndTask(REPROVADO);
        flow.addEndTask(APROVADO);

        
        //Definições das transições
        flow.setStartTask(ANALISE_CHEFIA);
        flow.from(ANALISE_CHEFIA).go(DECISAO_ANTECIPACAO_13);
        flow.from(DECISAO_ANTECIPACAO_13).go(ENVIAR_DIRETOR, ANALISE_DIRETOR);
        flow.from(DECISAO_ANTECIPACAO_13).go(ENVIAR_RH, ANALISE_RH);
        
        flow.from(ANALISE_DIRETOR).go("Aprovar", ANALISE_RH);
        flow.from(ANALISE_DIRETOR).go("Reprovar", REPROVADO);
                
        flow.from(ANALISE_RH).go("Aprovar", APROVADO);
        flow.from(ANALISE_RH).go("Reprovar", REPROVADO);
        flow.from(ANALISE_RH).go("Solicitar Ajustes", SOLICITACAO_COM_PENDENCIAS);
        
        flow.from(SOLICITACAO_COM_PENDENCIAS).go("Concluir Pendência", ANALISE_CHEFIA);
    }


}