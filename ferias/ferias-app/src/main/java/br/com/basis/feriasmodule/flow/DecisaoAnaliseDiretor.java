package br.com.basis.feriasmodule.flow;

import java.util.Optional;

import javax.inject.Inject;
import javax.inject.Named;

import org.opensingular.flow.core.ExecutionContext;
import org.opensingular.flow.core.FlowInstance;
import org.opensingular.flow.core.TaskJavaCall;
import org.opensingular.form.SIComposite;
import org.opensingular.requirement.commons.service.RequirementInstance;
import org.opensingular.requirement.commons.service.RequirementService;

import br.com.basis.feriasmodule.form.FeriasForm;

@Named
public class DecisaoAnaliseDiretor implements TaskJavaCall<FlowInstance> {
	
	@Inject
	private RequirementService requirementService;
	
	@Override
	public void call(ExecutionContext<FlowInstance> context) {
		
		RequirementInstance requirementInstance = requirementService.getRequirementInstance(context.getFlowInstance());
		Optional formOpt =  requirementService.findLastFormRequirementInstanceByType(requirementInstance, FeriasForm.class);
		
		if(formOpt.isPresent()) {
			SIComposite form = (SIComposite) formOpt.get();
			Boolean antecipar13  = (Boolean) form.getField("antecipar13").getValue();
			
			if(antecipar13) {
				context.setTransition(FeriasFlow.ENVIAR_DIRETOR);
			}else {
				context.setTransition(FeriasFlow.ENVIAR_RH);
			}
		}
	}
	

}
