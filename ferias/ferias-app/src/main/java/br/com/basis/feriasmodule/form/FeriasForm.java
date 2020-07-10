package br.com.basis.feriasmodule.form;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.function.Predicate;
import javax.annotation.Nonnull;

import org.opensingular.form.SIComposite;
import org.opensingular.form.SInfoType;
import org.opensingular.form.SInstance;
import org.opensingular.form.STypeComposite;
import org.opensingular.form.TypeBuilder;
import org.opensingular.form.type.core.SIInteger;
import org.opensingular.form.type.core.STypeBoolean;
import org.opensingular.form.type.core.STypeInteger;
import org.opensingular.form.type.core.STypeString;
import org.opensingular.form.type.util.SIYearMonth;
import org.opensingular.form.type.util.STypeYearMonth;
import org.opensingular.form.validation.InstanceValidatable;
import org.opensingular.form.view.SViewByBlock;

import static org.opensingular.form.util.SingularPredicates.typeValueIsTrueAndNotNull;

@SInfoType(spackage = FeriasPackage.class, name = "Ferias")
public class FeriasForm extends STypeComposite<SIComposite> {
	
	public STypeYearMonth inicio;
	public STypeYearMonth fim;
	public STypeInteger dias;
	public STypeInteger diasVendidos;
    public STypeBoolean isVenderDias;
    public STypeBoolean antecipar13;
    public STypeString observacao;


    @Override
    protected void onLoadType(@Nonnull TypeBuilder tb) {
        asAtr().displayString("Nova Solicitação");
        
        inicio = addField("inicio", STypeYearMonth.class);
        inicio
	        .asAtr().label("Início do período aquisitivo").required()
	        .asAtrAnnotation().setAnnotated()
	        .asAtrBootstrap().colPreference(2);
        
        fim = addField("fim", STypeYearMonth.class);
        fim
	        .asAtr().label("Fim do período aquisitivo").required()
	        .asAtrAnnotation().setAnnotated()
	        .asAtrBootstrap().colPreference(2);		
        		
        dias = this.addFieldInteger("dias", true);
        dias.asAtr().label("Quantidade de dias")
	        .asAtrAnnotation().setAnnotated()
	        .asAtrBootstrap().colPreference(2);
        
        isVenderDias = addFieldBoolean("isVenderDias", true);
        isVenderDias.withRadioView("Sim", "Não")
            .asAtr().label("Vender dias?").asAtrAnnotation().setAnnotated()
            .asAtrBootstrap().colPreference(2);
        
        diasVendidos = this.addFieldInteger("diasVendidos", true);
        diasVendidos.asAtr().label("Dias vendidos").dependsOn(isVenderDias).exists(this.isVenderDias())
			.asAtrAnnotation().setAnnotated()
			.asAtrBootstrap().colPreference(2);
        
                
        this.antecipar13 = this.addFieldBoolean("antecipar13", true);
        this.antecipar13.withRadioView("Sim", "Não")
        				.asAtr().label("Antecipar décimo terceiro?")
				        .asAtrAnnotation().setAnnotated()
						.asAtrBootstrap().colPreference(2);
        
        observacao = addFieldString("observacao");
        observacao
            .asAtr().required().label("Observações")
            .asAtrBootstrap().colPreference(12);
        observacao
            .withTextAreaView(sViewTextArea -> sViewTextArea.setLines(4))
            .asAtr().maxLength(4000).asAtrAnnotation().setAnnotated();
        
        this.addInstanceValidator(this::verificaNumeroDeDias);
        this.addInstanceValidator(this::verificaDatas);
        
        this.withView(new SViewByBlock(), block ->
            block.newBlock("Solicitação de férias")
            	.add(inicio)
            	.add(fim)
            	.add(dias)
                .add(isVenderDias)
                .add(diasVendidos)
                .add(antecipar13)
                .add(observacao)
            );
    }

    private Predicate<SInstance> isVenderDias() {
        return typeValueIsTrueAndNotNull(isVenderDias);
    }
    
    private void verificaNumeroDeDias(InstanceValidatable<SIComposite> validator) {
        SIComposite myForm = validator.getInstance();
 
        int diasFerias = myForm.findNearestOrException(dias).getInteger();
        int diasVender = myForm.findNearestOrException(diasVendidos).exists() ? 
        				 myForm.findNearestOrException(diasVendidos).getInteger() : 0;		
        
        if ((diasFerias + diasVender) > 30) {
            validator.error("A soma dos dias de férias com os dias vendidos não pode ser maior que 30");
        }
    }
   
    private void verificaDatas(InstanceValidatable<SIComposite> validator) {
        SIComposite myForm = validator.getInstance();
 
        SIYearMonth mesInicio = myForm.findNearestOrException(inicio);
        SIYearMonth mesFim = myForm.findNearestOrException(fim);
 
        if (mesInicio.isAfter(mesFim)) {
            validator.error("O início do peŕiodo aquisitivo não pode ser menor que o fim do período aquisitivo");
        }
    }
    
    public enum Profissoes {

        DESENVOLVEDOR("Desenvolvedor"),
        ANALISTA("Analista"),
        GERENTE("Gerente"),
        CEO("Diretor executivo");

        private String descricao;

        Profissoes(String descricao) {
            this.descricao = descricao;
        }

        @Nonnull
        public String getDescricao() {
            return descricao;
        }

        public static String[] valuesOfDescricao(){
            return Arrays.stream(values()).map(v -> v.descricao).toArray(String[]::new);
        }
    }
}

