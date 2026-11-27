import { mathjax } from 'mathjax-full/js/mathjax.js';
import { TeX } from 'mathjax-full/js/input/tex.js';
import { MathML } from 'mathjax-full/js/input/mathml.js';
import { CHTML } from 'mathjax-full/js/output/chtml.js';
import { TeXFont } from 'mathjax-full/js/output/chtml/fonts/tex.js';
import { browserAdaptor } from 'mathjax-full/js/adaptors/browserAdaptor.js';
import { RegisterHTMLHandler } from 'mathjax-full/js/handlers/html.js';
import { AllPackages } from 'mathjax-full/js/input/tex/AllPackages.js';
import zero from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Zero.woff';
import main from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Main-Regular.woff';
import mainBold from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Main-Bold.woff';
import mathItalic from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Math-Italic.woff';
import mainItalic from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Main-Italic.woff';
import mathBoldItalic from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Math-BoldItalic.woff';
import size1 from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Size1-Regular.woff';
import size2 from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Size2-Regular.woff';
import size3 from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Size3-Regular.woff';
import size4 from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Size4-Regular.woff';
import ams from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_AMS-Regular.woff';
import calligraphic from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Calligraphic-Regular.woff';
import calligraphicBold from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Calligraphic-Bold.woff';
import fraktur from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Fraktur-Regular.woff';
import frakturBold from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Fraktur-Bold.woff';
import sans from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_SansSerif-Regular.woff';
import sansBold from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_SansSerif-Bold.woff';
import sansItalic from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_SansSerif-Italic.woff';
import script from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Script-Regular.woff';
import typewriter from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Typewriter-Regular.woff';
import vector from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Vector-Regular.woff';
import vectorBold from 'mathjax-full/es5/output/chtml/fonts/woff-v2/MathJax_Vector-Bold.woff';

RegisterHTMLHandler(browserAdaptor());

// Replace CommonHTML's external font URLs with embedded WOFF data URLs.
const fonts = {
  MJXZERO: zero, MJXTEX: main, 'MJXTEX-B': mainBold,
  'MJXTEX-I': mathItalic, 'MJXTEX-MI': mainItalic,
  'MJXTEX-BI': mathBoldItalic, 'MJXTEX-S1': size1,
  'MJXTEX-S2': size2, 'MJXTEX-S3': size3, 'MJXTEX-S4': size4,
  'MJXTEX-A': ams, 'MJXTEX-C': calligraphic,
  'MJXTEX-CB': calligraphicBold, 'MJXTEX-FR': fraktur,
  'MJXTEX-FRB': frakturBold, 'MJXTEX-SS': sans,
  'MJXTEX-SSB': sansBold, 'MJXTEX-SSI': sansItalic,
  'MJXTEX-SC': script, 'MJXTEX-T': typewriter,
  'MJXTEX-V': vector, 'MJXTEX-VB': vectorBold,
};
for (const face of Object.values(TeXFont.defaultFonts)) {
  face.src = `url("${fonts[face['font-family']]}") format("woff")`;
}

const html = mathjax.document(document, {
  InputJax: [new TeX({packages: AllPackages.filter(name => name !== 'autoload' && name !== 'require')}), new MathML()],
  OutputJax: new CHTML(),
});

window.MathJax = {
  version: mathjax.version,
  typeset(elements) {
    html.clear();
    html.findMath({elements}).render();
  },
  typesetPromise(elements) {
    return mathjax.handleRetriesFor(() => this.typeset(elements));
  },
};
