package br.com.basis.feriasmodule.flow;

import br.com.basis.feriasmodule.flow.FeriasFlow;
import org.junit.Test;
import org.opensingular.requirement.commons.test.flow.AbstractFlowRenderTest;

public class FeriasFlowRenderTest extends AbstractFlowRenderTest {

    public FeriasFlowRenderTest() {
        setOpenGeneratedFiles(false);
    }

    @Test
    public void render() {
        super.renderImage(new FeriasFlow());
    }
}
